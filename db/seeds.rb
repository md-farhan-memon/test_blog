# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

## ADMIN
acc = Account.create({email: 'test@admin.com', password: 'test@1234', password_confirmation: 'test@1234'})
admin = Admin.new(email: acc.email)
admin.account = acc
admin.save!


## USER
acc = Account.create({email: 'test@user.com', password: 'test@1234', password_confirmation: 'test@1234'})
usr = User.create({email: acc.email, first_name: 'Test', last_name: 'User'})
acc.update_attribute(:accountable, usr)