import pytest

from primer.primality import is_prime


@pytest.mark.parametrize("n,expected", [
    (7, True),
    (10, False),
    (13, True),
    (42, False)
])
def test_is_prime(n, expected):
    assert is_prime(n) == expected
