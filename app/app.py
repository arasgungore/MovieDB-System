from flask import Flask, render_template

from db_manager import db_manager_bp
from director import director_bp
from audience import audience_bp

app = Flask(__name__)

app.secret_key = 'qwerty123'

# Register the blueprints
app.register_blueprint(db_manager_bp, url_prefix='/db_manager')
app.register_blueprint(director_bp, url_prefix='/director')
app.register_blueprint(audience_bp, url_prefix='/audience')

# Main page
@app.route('/')
def main():
    return render_template('main.html')

if __name__ == '__main__':
    app.run(debug=True)
