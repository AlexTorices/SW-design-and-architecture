class Student

    # Replace Magic Number with Symbolic Constant
    GOOD_GRADE_AVERAGE = 85
    ANUAL_INCOME_POVERTY_LIMIT = 15_000

    attr_reader :name, :id, :anual_income

    def initialize(name:, id:, anual_income:)
      @name = name
      @id = id
      @anual_income = anual_income
      @grades = []
    end

    def add_grade(grade)
      @grades << grade
      self
    end

    # Rename Method
    def display_info
        #Extract Method
        display_personal_information # Display Personal Information
        display_disclaimer # Display Disclaimer

    end

    def scholarship_worthy?
      # Nothing reasonable to do if this student has currently no grades.
      raise 'Student has no grades' if @grades.empty?

      has_good_grades = average >= GOOD_GRADE_AVERAGE
      is_poor = @anual_income < ANUAL_INCOME_POVERTY_LIMIT
      has_good_grades and is_poor
    end

    # Hide method
    private    # Extract Method
    def display_personal_information
        puts "Name: #{ @name } ID: #{ @id }"
        puts "Anual income: #{ @anual_income }"
        puts "Grade average: #{ average }"
    end

    def display_disclaimer
        puts 'The contents of this class must not be considered an offer,'
        puts 'proposal, understanding or agreement unless it is confirmed'
        puts 'in a document signed by at least five blood-sucking lawyers.'
    end

    def average
        @grades.sum / @grades.size.to_f
    end

  end