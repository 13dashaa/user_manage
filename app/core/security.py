from passlib.context import CryptContext

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


def get_hashed_pswd(password):
    return pwd_context.hash(password)


def verify_pswd(plain_pswd: str, hashed_pswd: str) -> bool:
    return pwd_context.verify(plain_pswd, hashed_pswd)