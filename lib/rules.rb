class Rules
  attr_reader :this_line

  def initialize(this_line, line_number, line_above = nil)
    @line_above = line_above
    @line_number = line_number + 1
    @this_line = this_line
    @error_messages = []
  end

private

  def first_line
    # p @this_line
    if @line_number == 1
      @error_messages.push(["'{' expected at the beginning of the line", @line_number]) unless @this_line[0] == '{'
    end
  end

  def after_curly
    if @this_line.include? '{'
      @error_messages.push(["New line expected after '{'", @line_number]) unless @this_line[@this_line.index('{') + 1] == "\n"
    end
    if @this_line.include? '}'
      @error_messages.push(["New line expected after '}'", @line_number]) unless @this_line[@this_line.index('}') + 1] == "\n"
    end
  end

  def after_colon
    if @this_line.include? ':'
      @this_line2 = @this_line.split("\"")
      @this_line2.each_with_index do |split, i|
        if split.include?(':') && !@this_line2[i+1].nil? && !split.include?('https')
          next_split = split[split.index(':') + 1]
          @error_messages.push(["Add space after ':'", @line_number]) if next_split  != " "
        end
      end
    end
  end

  def after_comma
    if @this_line.include? ','
      @this_line2 = @this_line.split("\"")
      @this_line2.each_with_index do |split, i|
        if split == ',' && !@this_line2[i+1].nil?
          @error_messages.push(["New line expected after ','", @line_number]) if split[split.index(',') + 1] != "\n"
        end
      end
    end
  end

  def after_square_bracket
    if @this_line.include?('[')
      @this_line2 = @this_line.split("\"")
      @this_line2.each_with_index do |split, i|

        if split.include?('[')
      
         @error_messages.push(["New line expected after '['", @line_number]) if split[split.index('[') + 1] != "\n"
        end
      end
    end
    if @this_line.include? '],'
      @error_messages.push(["Empty line is expected after '],'", @line_number]) unless @this_line[@this_line.index(']') + 1] == "\n" || @this_line[@this_line.index(']') + 1] == ',' 
    end
 end

 






=begin
  def after_comma
    if @this_line.include? ','
      @error_messages.push(["New line expected after ','", @line_number]) if @this_line[@this_line.index(',') + 1] != "\n"
    end
  end
=end
  #def after_square_bracket
   # if @this_line.include? '],'
    #  @error_messages.push(["Empty line is expected after '],'", @line_number]) unless @this_line[@this_line.index(']') + 1] == "\n"
    #end
  #end

=begin
  def after_curly
    if @this_line.include? '}'
      @error_messages.push(["New line expected after '}'", @line_number]) unless @this_line[@this_line.index('}') + 1] == "\n"
    end
  end

  def indentation
    no_indent = 0
    indent = 0

    if @this_line.include? "{"
      @error_messages.push(["Indentation is expected after '{'", @line_number])
    end
  end
=end

public

  def check_for_errors
    first_line 
    after_curly
    after_colon
   # after_comma
   # after_curly
   # after_square_bracket
    #indentation


    @error_messages
  end
end
