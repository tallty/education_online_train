json.extract! admin_syllabus, :id, :course_time, :title, :content, :teacher, :address, :created_at, :updated_at
json.training_course_name admin_syllabus.training_course.try(:name)

