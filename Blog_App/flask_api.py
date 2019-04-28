from flask import Flask
from flask import request
from flask_restful import Resource, Api
from flask_restful import reqparse
from flaskext.mysql import MySQL
import json
import datetime
from flask import jsonify
import datetime
from flask_sqlalchemy import SQLAlchemy

# mysql = MySQL()
app = Flask(__name__)

# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'blog'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'

# mysql.init_app(app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///db.sqlite3'
db = SQLAlchemy(app)


class PostsPost(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(120))
    content = db.Column(db.String(120))
    created_at = db.Column(db.DateTime(), default=datetime.datetime.utcnow)
    updated_at = db.Column(db.DateTime(), default=datetime.datetime.utcnow)


api = Api(app)


# class CreateBlog(Resource):
# 	def post(self):
# 		try:
# 			# Parse the arguments
# 			parser = reqparse.RequestParser()
# 			parser.add_argument('title', type=str, help='Name of the blog')
# 			parser.add_argument('content', type=str, help='Content of the blog')
# 			args = parser.parse_args()

# 			_blogname = args['title']
# 			_content = args['content']
		

# 			# conn = mysql.connect()
# 			# cursor = conn.cursor()

# 			# cursor.callproc('spCreateBlog',(_blogname,_content,))
# 			# data = cursor.fetchall()

# 			if len(data) is 0:
# 				conn.commit()
# 				return {'StatusCode':'200','Message': 'Blog creation success'}
# 			else:
# 				return {'StatusCode':'1000','Message': str(data[0])}


# 			#return {'Email': args['email'], 'Password': args['password'] }

# 		except Exception as e:
# 			return {'error': str(e)}

def convert_timestamp(item_date_object):
	if isinstance(item_date_object, (datetime.date, datetime.datetime)):
		return item_date_object.timestamp()


class GetBlog(Resource):
	def get(self):
		p = PostsPost.query.all()
		posts = [{'title':p_i.title, 'content':p_i.content, 'created_at':p_i.created_at, 'updated_at':p_i.updated_at} for p_i in p]
		# print(posts)
		return jsonify(posts) 		


	def post(self):
		parser = reqparse.RequestParser()
		parser.add_argument('title', type = str,)
		parser.add_argument('content', type = str)
		args = parser.parse_args()
		print(args)
		p = PostsPost(title=args['title'], content=args['content'])
		db.session.add(p)
		db.session.commit()
		json = {}
		json['title'] = p.title
		json['content'] = p.content
		json['created_at'] = p.created_at
		json['updated_at'] = p.updated_at
		return jsonify(json)

class GetBlogList(Resource):

	def get(self, id):
		
		p = PostsPost.query.filter_by(id=int(id))[0]
		print(p.__dict__)
		json = {}
		json['title'] = p.title
		json['content'] = p.content
		json['created_at'] = p.created_at
		json['updated_at'] = p.updated_at
		return jsonify(json)

	

api.add_resource(GetBlog, '/api/')
api.add_resource(GetBlogList, '/api/<int:id>/')

# api.add_resource(CreateBlog, '/CreateBlog')

if __name__ == '__main__':
	app.run(debug=True)


