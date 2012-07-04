namespace :admin do 
  task :set_invites => :environment do 
    lkuser = User.find_by_email("larry.kooper@gmail.com")
    lkuser.update_attributes(:invitation_limit => 99999)
    lkuser.save
    puts "done"
  end
  
  task :set_name => :environment do 
    lkuser = User.find_by_email("larry.kooper@gmail.com")
    lkuser.update_attributes(:first_name => 'Larry', :last_name => 'Kooper')
    lkuser.save
    puts "done"
  end   
end