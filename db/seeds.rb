default_teacher = User.teacher.find_by(email: 'teacher@example.com')
unless default_teacher
  User.create(email: 'teacher@example.com', password: '12345678', password_confirmation: '12345678',
              name: 'Default Teacher', role: :teacher, uid: 'teacher@example.com')
end
