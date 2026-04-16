import os
from typing import Optional, List
from dataclasses import dataclass
from datetime import datetime

@dataclass
class User:
    id: int
    name: str
    email: str
    created_at: datetime

class UserRepository:
    def __init__(self, db_session):
        self.db = db_session

    def find_by_id(self, user_id: int) -> Optional[User]:
        return self.db.query(User).filter(User.id == user_id).first()

    def find_all(self) -> List[User]:
        return self.db.query(User).all()

    async def create(self, user_data: dict) -> User:
        user = User(**user_data)
        self.db.add(user)
        return user

@staticmethod
def validate_email(email: str) -> bool:
    return '@' in email and '.' in email

def get_user_display_name(user: User) -> str:
    return f"{user.name} <{user.email}>"

async def fetch_users_from_api(url: str) -> List[dict]:
    pass
