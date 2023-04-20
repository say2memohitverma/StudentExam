class UserContract < Dry::Validation::Contract
  params do
    required(:first_name).filled(:string)
    required(:last_name).filled(:string)
    required(:phone_number).filled(:string)
    required(:college_id).value(:integer)
    required(:exam_id).value(:integer)
    required(:start_time).value(:date_time)
  end

  rule(:start_time) do
      key.failure("a requested start_time does not fall with in an exam's time window") unless Exam.find_by(id: values[:exam_id]).present? && Exam.find_by(id: values[:exam_id]).exam_window.start_time == value
  end

  rule(:college_id) do
    key.failure("a college with the given college_id is not found") unless College.find_by(id: value).present?
  end

  rule(:exam_id) do
    key.failure("an exam with the given exam_id is not found or does not belong to the college") unless College.find_by(id: value).present?
  end
end