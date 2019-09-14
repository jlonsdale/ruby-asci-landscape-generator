@random_seed = []
@mountains = []
@viewable =[]

def print_menu
  puts "enter 1 to create a 2D landscape"
  puts "enter 2 to fill landscape with water"
  puts "enter 3 to view current landscape"
  puts "enter 4 to quit"
end

def create_landscape
  puts "Input max height of mountains"
  height = (gets.chomp).to_i
  puts "Input length of mountains"
  length = (gets.chomp).to_i
  @random_seed = length.times.map {Random.rand(height+1)}
  @mountains = (height+3).times.map { [] }
  @viewable = []
  @mountains.each_with_index do |level,i|
    @random_seed.each do |n|
    level.push("#") if n<i
    level.push(" ") if n>=i
  end
  @viewable.push(level.join)
end

def fill_water
  @viewable = []
  @mountains.each_with_index do |level,i|
    #water can only land if more than 2 '#' exist in one level
    has_water = false
    counter = 0
    level.each do |x|
      if x == "#"
        counter += 1
      end
    end
    #does this level have water?
    has_water = true if counter >= 2
    if has_water == true
      level.each_with_index do |x, j|
        if level[j] == "#" && level[j+1] == " "
           level[j+1] = "~"
        elsif level[j] == "~" && level[j+1] == " "
            level[j+1] = "~"
        end
      end
    end
    level.reverse!
    level.each_with_index do |x, j|
      if level[j] == "#"
        break
      end
      level[j] = " "
    end
    level.reverse!
    @viewable.push(level.join)
    end
  end
end

def interactive_menu
  loop do
      print_menu
      input = gets.chomp
      case input
      when "1"
        create_landscape
      when "2"
        if @mountains.empty? == true
          puts 'Please make a landscape first!'
          next
        else
          fill_water
        end
      when "3"
        if @mountains.empty? == true
          puts 'Please make a landscape first!'
          next
        else
          puts @viewable
        end
      when "4"
        break
      else
        puts "I don't know what you meant, try again"
        end
    end
end


interactive_menu
