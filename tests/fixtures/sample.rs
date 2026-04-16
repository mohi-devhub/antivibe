use std::collections::HashMap;

pub struct User {
    pub id: u64,
    pub name: String,
    pub email: String,
}

pub enum UserRole {
    Admin,
    User,
    Guest,
}

pub trait Repository {
    fn find_by_id(&self, id: u64) -> Option<&User>;
    fn find_all(&self) -> Vec<&User>;
}

impl User {
    pub fn new(id: u64, name: String, email: String) -> Self {
        Self { id, name, email }
    }
}

pub async fn fetch_user(id: u64) -> Result<User, String> {
    Ok(User::new(id, "Test".into(), "test@example.com".into()))
}

fn validate_email(email: &str) -> bool {
    email.contains('@') && email.contains('.')
}
