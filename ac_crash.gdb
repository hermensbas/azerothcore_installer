define hook-stop
  echo \n===== CRASH DETECTED =====\n
  bt full
  thread apply all bt
  echo \n===== END CRASH =====\n
end
