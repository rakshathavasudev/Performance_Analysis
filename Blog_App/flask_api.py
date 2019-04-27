from flask import Flask
from flask import request
from flask_restful import Resource, Api
from flask_restful import reqparse
from flaskext.mysql import MySQL

mysql = MySQL()
app = Flask(__name__)

# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'blog'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'

mysql.init_app(app)
api = Api(app)


class CreateBlog(Resource):
	def post(self):
		try:
			# Parse the arguments
			parser = reqparse.RequestParser()
			parser.add_argument('blog_name', type=str, help='Name of the blog')
			parser.add_argument('content', type=str, help='Content of the blog')
			args = parser.parse_args()

			_blogname = args['blog_name']
			_content = args['content']
		

			conn = mysql.connect()
			cursor = conn.cursor()

			cursor.callproc('spCreateBlog',(_blogname,_content,))
			data = cursor.fetchall()

			if len(data) is 0:
				conn.commit()
				return {'StatusCode':'200','Message': 'Blog creation success'}
			else:
				return {'StatusCode':'1000','Message': str(data[0])}


			#return {'Email': args['email'], 'Password': args['password'] }

		except Exception as e:
			return {'error': str(e)}


class GetBlog(Resource):
	def get(self):
		try:
			# Parse the arguments
			parser = reqparse.RequestParser()
			parser.add_argument('blog_name', type=str, help='Name of the blog')
			#parser.add_argument('password', type=str, help='Password to create user')
			args = parser.parse_args()

			_blogname = args['blog_name']
			#_userPassword = args['password']

			conn = mysql.connect()
			cursor = conn.cursor()

			cursor.callproc('spGetBlogbyname',(_blogname,))
			data = cursor.fetchall()
			if (len(data)>0):
				return {'StatusCode':'200','Message':'Blog exists'}
			else:
				return {'StatusCode':'1000','Message': 'Blog not found'}

		except Exception as e:
			return {'error': str(e)}


api.add_resource(GetBlog, '/GetBlog')
api.add_resource(CreateBlog, '/CreateBlog')

if __name__ == '__main__':
	app.run(debug=True)

