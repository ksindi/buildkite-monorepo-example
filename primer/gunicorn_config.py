import multiprocessing

PORT = 3000
HOST = '0.0.0.0'

bind = f'{HOST}:{PORT}'
workers = multiprocessing.cpu_count() * 2 + 1
max_requests = 200
max_requests_jitter = 50
keepalive = 60

loglevel = 'info'
