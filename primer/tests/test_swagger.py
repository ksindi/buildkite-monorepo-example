from swagger_tester import swagger_test

authorize_error = {
    'get': {
        '/health': [200],
        '/primality': [200]
    }
}


def test_swagger():
    swagger_test('swagger.yml', authorize_error=authorize_error, use_example=True)
