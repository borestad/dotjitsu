require 'fileutils'

class String
  def red;       "\e[31m#{self}\e[0m" end
  def green;     "\e[32m#{self}\e[0m" end
  def yellow;    "\e[33m#{self}\e[0m" end
  def pink;      "\e[35m#{self}\e[0m" end
  def bold;      "\e[1m#{self}\e[22m" end
  def italic;    "\e[3m#{self}\e[23m" end
  def underline; "\e[4m#{self}\e[24m" end
end

OK                = '✓ OK      '.green.bold
INSTALLING        = '➤ INSTALL '.green.bold
ERROR             = '✖ ERROR   '.red.bold
EXISTS            = '✓ EXISTS  '.bold.pink
QUESTION          = '★ INPUT   '.yellow.bold

class Installer

  def symlink
    dotfiles.each do |src|
      dest = "~/#{src}"

      from = File.expand_path(src)
      to = File.expand_path(dest)

      if File.exist?(to)
        puts "#{EXISTS} #{dest} already exists"
      else
        puts "#{OK} Linking #{dest}"
        link(from, to)
      end
    end
  end

  def dotfiles
    Dir['.*'] - %w(. .. .git .DS_Store)
  end

  def link(from, to)
    FileUtils.ln_s(from, to)
  end

  def install_oh_my_zsh
    is_available = File.exist?(File.expand_path "~/.oh-my-zsh" )

    if is_available
      puts "#{EXISTS} 'oh-my-zsh' already installed"
    else is_available
      print "#{QUESTION} Install oh-my-zsh? [y/n/q] "
        case $stdin.gets.chomp
        when 'y'
          puts "#{OK} installing oh-my-zsh"
          system %Q{git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"}
        when 'q'
          exit
        else
          puts "skipping oh-my-zsh, you will need to change ~/.zshrc"
        end
    end
  end


  def install_homebrew
    system %Q{ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"}
  end

end

puts ''

desc 'Bootstrap'

task :symlink do
  Installer.new.symlink
end

task :bootstrap do
  Installer.new.install_homebrew
  Installer.new.install_oh_my_zsh
end

desc 'Install'
task :install do
  Installer.new.install
end

# Always return new line
at_exit { puts '' if $!.nil? }
