# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do |n|
  email = Faker::Internet.email
  name = Faker::Internet.user_name
  password = "password"
  provider = Faker::Lorem.unique.word
  uid = Faker::Number.unique
  User.create!(
    email: email,
    name: name,
    provider: provider,
    uid: uid,
    password: password,
    password_confirmation: password
  )
end

n = 1
while n <= 100
  title = Faker::Lorem.word
  topic_content = Faker::Lorem.word
  Topic.create(
    title: title,
    content: topic_content,
    user_id: n
  )
  f = 1
  while f <= 5
    user_id = Faker::Number.between(1,100)
    comment_content = Faker::Lorem.word
    Comment.create(
      content: comment_content,
      topic_id: n,
      user_id: user_id
    )
    f = f + 1
  end

  sender_id = n
  recipient_id = n + 1
  conversation_id = n
  if n == 100
    Conversation.create(
      sender_id: sender_id,
      recipient_id: 1
    )
  else
    Conversation.create(
      sender_id: sender_id,
      recipient_id: recipient_id,
    )
  end

  x = 1
  while x <= 5
    message_body_sender = Faker::Lorem.word
    message_body_recipient = Faker::Lorem.word
    if n == 100
      Message.create(
        user_id: 1,
        conversation_id: n,
        body: message_body_recipient
      )
    else
      Message.create(
        user_id: recipient_id,
        conversation_id: n,
        body: message_body_recipient
      )
    end
    Message.create(
      user_id: sender_id,
      conversation_id: n,
      body: message_body_sender
    )
    x = x + 1
  end

  n = n + 1
end
