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
app.config['MYSQL_DATABASE_DB'] = 'itemlistdb'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'

mysql.init_app(app)
api = Api(app)


class CreateUser(Resource):
	def post(self):
		try:
			# Parse the arguments
			parser = reqparse.RequestParser()
			parser.add_argument('name', type=str, help='Name to create user')
			parser.add_argument('email', type=str, help='Email address to create user')
			parser.add_argument('password', type=str, help='Password to create user')
			args = parser.parse_args()

			_userName = args['name']
			_userEmail = args['email']
			_userPassword = args['password']

			conn = mysql.connect()
			cursor = conn.cursor()

			cursor.callproc('spCreateUser',(_userName,_userEmail,_userPassword))
			data = cursor.fetchall()

			if len(data) is 0:
				conn.commit()
				return {'StatusCode':'200','Message': 'User creation success'}
			else:
				return {'StatusCode':'1000','Message': str(data[0])}


			#return {'Email': args['email'], 'Password': args['password'] }

		except Exception as e:
			return {'error': str(e)}





api.add_resource(CreateUser, '/CreateUser')

if __name__ == '__main__':
	app.run(debug=True)

