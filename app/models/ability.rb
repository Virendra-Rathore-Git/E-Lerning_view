class Ability
  include CanCan::Ability

  def initialize(user)

    if user.type == "Teacher"
      can [ :index, :show, :create, :update, :destroy ] , Course , teacher_id: user.id
    elsif user.type == "Student"
      can [ :manage ], Enrollment , student_id: user.id 
      can [:index ] , Course , student_id: user.id 
    end
  end
end
