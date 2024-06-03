class SchoolClassesController < ApplicationController
  # т.к в api.yml не была указана схема школы, я не делал ее модель, поэтому у меня нет связи школы и класса
  # поэтому я просто выбираю все классы
  def school_classes
    school_classes = SchoolClass.all
    render(json: { data: school_classes }, status: :ok)
  end
end
