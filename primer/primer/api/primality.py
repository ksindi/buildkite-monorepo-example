from primer.primality import is_prime


def search(n):
    return dict(is_prime=is_prime(n)), 200
