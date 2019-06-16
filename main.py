from flask import Flask,render_template,request,session,redirect
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import json,os
from flask_mail import Mail  #in vdo #11
from werkzeug import secure_filename
from flask_mail import Message

from math import ceil

with open('config.json','r') as j:
    params=json.load(j)["params"] 

local_server=params["local_server"]

app = Flask(__name__)
#app.secret_key = 'super-secret-key'
app.config['SECRET_KEY'] = 'super-secret-key' #substitute for above line
app.config['upload_folder'] = params['upload_file_path']



'''from "https://pythonhosted.org/Flask-Mail/"
MAIL_SERVER : default ‘localhost’
MAIL_PORT : default 25
MAIL_USE_TLS : default False
MAIL_USE_SSL : default False
MAIL_DEBUG : default app.debug
MAIL_USERNAME : default None
MAIL_PASSWORD : default None
MAIL_DEFAULT_SENDER : default None
MAIL_MAX_EMAILS : default None
MAIL_SUPPRESS_SEND : default app.testing
MAIL_ASCII_ATTACHMENTS : default False
'''
app.config.update(
    MAIL_SERVER = "smtp.gmail.com",
    MAIL_PORT = "465",
    MAIL_USE_TLS = False,
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params['gmail_user'],
    MAIL_PASSOWRD = params['gmail_pwd']
)

mail=Mail(app)
#app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:@localhost/test'
#below is as fetched from config json file
if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["local_uri"]
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["prod_uri"]

db = SQLAlchemy(app)

class Contact(db.Model):
    #sno,name,email,phone,msg,date
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(30), unique=False, nullable=False)
    email = db.Column(db.String(50), unique=True, nullable=False)
    phone = db.Column(db.String(12),  nullable=False)
    msg = db.Column(db.String(200), nullable=False)
    date = db.Column(db.String(12), nullable=True)

class Posts(db.Model):
    #sno,title,slog,content,date
    srno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), unique=False, nullable=False)
    slug = db.Column(db.String(30), unique=True, nullable=False)
    content = db.Column(db.String(500),  nullable=False)
    tagline = db.Column(db.String(75),  nullable=False)
    img_file_name = db.Column(db.String(50),  nullable=True)
    date = db.Column(db.String(12), nullable=True)


@app.route("/dashboard", methods=['GET','POST'])
def dashboad():

    print('here')
    print(session.get('usr'))
    #print("session variable value: ", session['usr'])
    
    #if user already logged in, redirect to direct dashboad without login pagex

    #session['usr'] == 'Anything'

    if ('usr' in session and session['usr'] == params['adm_user']):
        posts = Posts.query.all()        
        return render_template('dashboard.html',params=params,posts=posts)

    print("here1")
    if request.method == 'POST':    #redirect to admin panel
        print("here2")
        user_name = request.form.get('uname')
        pwd = request.form.get('pass')
        print("Captured user n pwd ", user_name,pwd)
        print("Configured user n pwd ", params['adm_user'] , params['adm_pwd'])

        #print(user_name,pwd)

        if (user_name == params['adm_user'] and pwd == params['adm_pwd']):
            #set the session variable
            print("sahi user")
            
            #session['usr'] == user_name
            posts = Posts.query.all()
            return render_template('dashboard.html',params=params,posts=posts)
    else:  
    #if request.method == 'POST':    
        return render_template("login.html",params=params)

@app.route("/",methods=['GET','POST'])
def home():
    #pagination logic
    posts = Posts.query.filter_by().all()
    last = ceil(len(posts)/int(params['posts_per_page']))
    page = request.args.get('page')
    print("page here1", page)

    if (not str(page).isnumeric()):
        page = 1
    print("page here2", page)
    page = int(page)
    #slicing post starts from 0 to zero + post per page
    posts = posts[(page-1)*int(params['posts_per_page']) : (page-1)*int(params['posts_per_page']) + int(params['posts_per_page'])]

    if page == 1:
        prev = '#'
        nextt = "/?page=" + str(page + 1)
    elif page == last:
        prev = "/?page=" + str(page - 1)
        nextt = '#'
    else:
        prev = "/?page=" + str(page - 1) 
        nextt = "/?page=" + str(page + 1)

    print(f"page: {page}, last: {last}, prev: {prev}, next: {nextt}")

    
    #page first
        #prev = #
        #next = page+1
    #page middle
        #prev = page-1
        #next = page+1
    #page last
        #mh27 4089
        #prev = page-1
        #next = #
    return render_template('index.html',params=params,posts=posts,prev=prev,nextt=nextt)

#commented below for pagination logic
#    posts = Posts.query.filter_by().all()[0:params['posts_per_page']] #limiting no of posts on index page, variable taken from config.json
#    return render_template("index.html",params=params,posts=posts)


@app.route("/post/<string:post_slug>", methods=['GET'])
def posts(post_slug):
#fetch posts from db
    post = Posts.query.filter_by(slug=post_slug).first()        #to get only 1st slug if multiples are there

    return render_template("post.html",params=params,post=post)


@app.route("/about")
def about():
    return render_template("about.html",params=params)


@app.route("/contact",methods=['GET','POST'])
def contact():
    if request.method == 'POST':
        #add entry to the database contact table
        name = request.form.get("name")
        email = request.form.get("email")
        phone = request.form.get("phone")
        msg = request.form.get("msg")        
        
        entry = Contact(name=name,email=email,phone=phone,msg=msg,date=datetime.now())
        db.session.add(entry)
        
        #send mail before commit the entry in db
        msg = Message(subject="hello",
                        sender=app.config.get("MAIL_USERNAME"),
                        recipients=[params['gmail_user']],
                        body="This is a test email I sent with Gmail and Python!")

        mail.send(msg)
        '''
        mail.send_message("New message from " + name,sender=email,
                            recipients=[params['gmail_user']],
                            body=msg + '\n' + phone)
        #mail server giving sender refused error
'''
        db.session.commit()

        #sending mail
        #mail.send_message("New message from " + name,sender=email,recipients=[params['gmail_user']],body=msg + '\n' + phone)
        #mail server giving sender refused error
    return render_template("contact.html",params=params)



@app.route("/edit/<string:srno>", methods=['GET','POST'])
def edit(srno):

#    if ('usr' in session and session['usr'] == params['adm_user']):
    if request.method == 'POST':
        box_title = request.form.get('title')
        tagline = request.form.get('tagline')
        slug = request.form.get('slug')
        content = request.form.get('content')
        image = request.form.get('image')
        date = datetime.now()

        if srno == '0':
            post = Posts(title=box_title,slug=slug,content=content,tagline=tagline,img_file_name=image,date=datetime.now())
            db.session.add(post)
            db.session.commit()
        else:
            post = Posts.query.filter_by(srno=srno).first()
            post.title = box_title
            post.tagline = tagline
            post.slug = slug
            post.content = content
            post.img_file_name = image
            post.date = date
            db.session.commit()
            return redirect("/edit/"+srno)
    posts = Posts.query.filter_by(srno=srno).first()

    #return render_template("edit.html",params=params,srno=srno)
    return render_template("edit.html",params=params,posts=posts)

'''
        posts = Posts.query.all()        
        return render_template('dashboard.html',params=params,posts=posts)

    posts = Posts.query.filter_by().all()[0:params['posts_per_page']] #limiting no of posts on index page, variable taken from config.json
    return render_template("index.html",params=params,posts=posts)
'''
#delete posts for correct login user

@app.route("/delete/<string:srno>", methods=['GET','POST'])
def delete(srno):
    #if ('usr' in session and session['usr'] == params['adm_user']):
    post = Posts.query.filter_by(srno=srno).first() # to get only single post and not the list
    db.session.delete(post)
    db.session.commit()
    return redirect('/dashboard')

#Upload files from dashboad page
@app.route("/uploader", methods=['GET','POST'])
def uploader():
    
    #if ('usr' in session and session['usr'] == params['adm_user']):
    if request.method == 'POST':
        f = request.files['file1']
        f.save(os.path.join(app.config['upload_folder'],secure_filename(f.filename)))   #f.filename))    #secure_filename(f.filename)))
        
        return "File upload success"



#Logout page # it is not working key user error
@app.route("/logout")
def logout():
    #if ('usr' in session and session['usr'] == params['adm_user']):
    session.pop('user')
    return redirect("/dashboard")



app.run(debug=True)