def is_prime(n):
    """Return boolean if argument is prime number.

    >>> is_prime(10)
    False
    >>> is_prime(7)
    True
    """
    if n < 2:
        return False

    if n == 2:
        return True

    if not n & 1:
        return False

    for x in range(3, int(n**0.5) + 1, 2):
        if n % x == 0:
            return False

    return True
