admin = User.create!(
  email: 'admin@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  full_name: 'Admin User',
  role: 'admin',
  confirmed_at: Time.current
)

5.times do |i|
  user = User.create!(
    email: "user#{i+1}@example.com",
    password: 'password123',
    password_confirmation: 'password123',
    full_name: "Regular User #{i+1}",
    role: 'user',
    confirmed_at: Time.current
  )
  
10.times do |j|
    status = ['pending', 'in_progress', 'completed'].sample
    due_date = rand(10).days.from_now
    
    user.tasks.create!(
      title: "Task #{j+1} for #{user.full_name}",
      description: "This is a description for task #{j+1}",
      status: status,
      due_date: due_date
    )
  end
end

puts "Seeds created successfully!"