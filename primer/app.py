import connexion

app = connexion.FlaskApp(__name__)
app.add_api('swagger.yml',
            resolver=connexion.RestyResolver('primer.api'),
            strict_validation=True,
            validate_responses=True)


if __name__ == '__main__':
    app.run()
