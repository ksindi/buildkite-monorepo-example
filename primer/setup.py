from setuptools import setup, find_packages

setup(
    name='primer',
    packages=find_packages(exclude=['tests']),
    install_requires=[
        'structlog==17.2.0',
        'gunicorn==19.7.1',
        'connexion==1.1.16',
    ],
    zip_safe=False,
    include_package_data=True,
    extras_require={
        'test': [
            'pytest',
            'pytest-cov',
            'swagger_tester',
        ]
    },
)
