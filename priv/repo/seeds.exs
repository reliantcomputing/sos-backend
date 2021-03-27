waiter_role_name = "WAITER"
manager_role_name = "MANAGER"
kitchen_role_name = "KITCHEN"
super_admin_role_name = "SUPER_ADMIN"

waiter_role = %{name: waiter_role_name, description: "Waiter"}
manager_role = %{name: manager_role_name, description: "Manager"}
kitchen_role = %{name: kitchen_role_name, description: "Kitchen"}
super_admin_role = %{name: super_admin_role_name, description: "Super Admin"}

waiter = Sos.Roles.get_role_by_name(waiter_role_name)
manager = Sos.Roles.get_role_by_name(manager_role_name)
kitchen = Sos.Roles.get_role_by_name(kitchen_role_name)
super_admin = Sos.Roles.get_role_by_name(super_admin_role_name)

if !waiter do
  Sos.Roles.create_role(waiter_role)
end

if !manager do
  Sos.Roles.create_role(manager_role)
end

if !kitchen do
  Sos.Roles.create_role(kitchen_role)
end

if !super_admin do
  Sos.Roles.create_role(super_admin_role)
end

emp_id = Sos.Randomizer.randomizer(8)

user = %{
  first_name: "Tumisho",
  last_name: "Mothobekhi",
  email: "tumi.manager@gmail.com",
  emp_id: "#{emp_id}",
  phone_number: "07385945862",
  street_name: "Sekoting",
  password: "Tumisho101101",
  house: "335"
}

if !Sos.Accounts.get_user_by_email(user.email) do
  role = Sos.Roles.get_role_by_name(manager_role_name)
  IO.inspect(Sos.Accounts.register_user(role, user))
#  Sos.Accounts.register_user(role, user)
end
