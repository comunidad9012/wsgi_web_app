import os

from config import APP_CONFIG
from werkzeug.middleware.shared_data import SharedDataMiddleware
from wsgi_app import make_response, render_template, wsgi


def create_app(with_static=True):
    new_app = wsgi()

    if with_static:
        new_app.app = SharedDataMiddleware(
            new_app.app,
            {"/static": os.path.join(os.path.dirname(__file__), "static")},
        )

    @new_app.route(["/", "/home"])
    def home_page(request):
        return make_response(render_template("home.html"))

    import auth

    new_app.register_blueprint(auth.bp)

    return new_app


if __name__ == "__main__":
    app = create_app()
    app.run(**APP_CONFIG)
