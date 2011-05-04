require "factory_girl"

Factory.define :user do |u|
  u.sequence(:email) { |n| "user#{n}@example.com" }
  u.password "s3cr3t"
  u.password_confirmation "s3cr3t"
end

Factory.define :admin_user, :parent => :user do |u|
  u.sequence(:email) { |n| "admin#{n}@example.com" }
end

Factory.define :ticket, :class => "Roundtrip::Ticket" do |t|
  t.summary "Someone is wrong on the internet!"
  t.association :reporter, :factory => :user
end
