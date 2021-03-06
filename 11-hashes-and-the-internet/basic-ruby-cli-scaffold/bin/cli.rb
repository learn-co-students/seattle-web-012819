# Here's your CLI class! I've included some starter code so you
#   can get a sense on how you might use it! Remember: this
#   class doesn't represent anything in your databse: it's
#   here simply to encapsulate your CLI methods!

# Pro-tip: think about how you might use class and instance 
#   variables in a class like this!

class CLI
  def initialize
    puts "Initializing new CLI"
  end

  def main_menu
    puts "What would you like to do?"
    puts "0. exit"
    puts "1. browse reddit"
    puts "2. search books"
    answer = gets.chomp.downcase
    puts

    if answer[0] == "1"
      browse_reddit
    elsif answer == "2"
      browse_books
    else
      puts "Incorrect choice!"
      return self.main_menu
    end
  end

  def browse_reddit
    response = RestClient.get("http://reddit.com/.json")
    jj = JSON.parse(response.body)
    jj["data"]["children"].each_with_index do |post, index|
      puts "#{index}. " + post["data"]["title"]
    end
  end

  def browse_books
    puts "What books are you looking for?"
    query = gets.chomp.downcase
    puts

    response = RestClient.get("https://www.googleapis.com/books/v1/volumes?q=" + query)
    jj = JSON.parse(response.body)
    jj["items"].each_with_index do |book, index|
      title = book["volumeInfo"]["title"]
      authors = book["volumeInfo"]["authors"].join(", ")
      puts title
      puts "by " + authors
      puts
    end
  end
end