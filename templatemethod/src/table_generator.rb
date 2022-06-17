# Template Method Pattern
# Date: 03-Mar-2022
# Authors:
#          A01377744 Alejandro Torices Oliva
#          A01376544 Mariana Paola Caballero Cabrera
# File name: table_generator.rb

# Models an abstract class that generates tables (template).
# It's intended to be modified to generate tables in different formats (template method).
class TableGenerator

  def initialize(header, data)
    @header = header
    @data = data
  end

  # Generates a table with headers at the top and multiple rows.
  def generate
    generate_header_row + (@data.map {|x| generate_row(x)}).join
  end

  # Generates a header row, containing multiple items
  def generate_header_row
    (@header.map {|x| generate_header_item(x)}).join
  end

  # Generates an item
  def generate_item(item)
    item
  end

  # Generates a data row, containing multiple items
  def generate_row(row)
    (row.map {|x| generate_item(x)}).join
  end

  # Generates a header item
  def generate_header_item(item)
    item
  end

end

# Models a table in CSV format. Inherits from TableGenerator
class CSVTableGenerator < TableGenerator

  # Modifies generate row from TableGenerator
  # Inserts a <em>,</em> between items
  def generate_row(row)
    "#{(row.map {|x| generate_item(x)}).join(',')}\n"
  end

  # Generates the header row the same way it does with data rows
  def generate_header_row
    generate_row(@header)
  end

end

# Models a table in HTML format. Inherits from TableGenerator
class HTMLTableGenerator < TableGenerator

  # Generates the table between <em>table</em> delimiters
  def generate
    "#{'<table>'}\n" + generate_header_row + (@data.map {|x| generate_row(x)}).join + "#{'</table>'}\n"
  end

  # Generates each row between <em>tr</em> delimiters and each item between <em>td</em> delimiters
  def generate_row(row)
    "#{'<tr><td>'+(row.map {|x| generate_item(x)}).join('</td><td>')+'</td></tr>'}\n"
  end

  # Generates each header row between <em>tr</em> delimiters and each item between <em>th</em> delimiters
  def generate_header_row
    "#{'<tr><th>'+(@header.map {|x| generate_item(x)}).join('</th><th>')+'</th></tr>'}\n"
  end
end

# Models a table in AsciiDoc format. Inherits from TableGenerator
class AsciiDocTableGenerator < TableGenerator

  # Generates the table with an <em>'[options="header"]'</em> header.
  # The table is written between <em>|==========</em>
  def generate
    "#{'[options="header"]'}\n" +
    "#{'|=========='}\n" +
    generate_header_row + (@data.map {|x| generate_row(x)}).join +
    "#{'|=========='}\n"
  end

  # Each item in the row has a charcter <em>|</em> before them
  def generate_row(row)
    "#{'|'+(row.map {|x| generate_item(x)}).join('|')}\n"
  end

  # Generates the header row the same way it does with data rows
  def generate_header_row
    generate_row(@header)
  end
end