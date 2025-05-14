local bad_patterns = {
    -- Disk/System Nukers
    "rm%s+%-rf%s+/",                     -- Blocks 'rm -rf /'
    "dd%s+if=.-%s+of=.-/dev/",           -- Blocks 'dd if=/dev/zero of=/dev/sda'
    "mkfs%.%w+%s+/dev/",                 -- Blocks 'mkfs.ext4 /dev/sda1'
    "chmod%s+%-R%s+[07]+%s+/",           -- Blocks 'chmod -R 000 /' or '777 /'
    
    -- Command Injections
    "%$%b()",                            -- Blocks $(malicious_command)
    "`.-`",                              -- Blocks `malicious_command`
    
    -- Fork Bombs
    ":%(%)%s*{:%|:%&};:",                -- Blocks :(){ :|:& };:
    
    -- Network Exploits
    "curl%s+.+%|%s*sh",                  -- Blocks 'curl evil.com | sh'
    "wget%s+.+%|%s*sh",                  -- Blocks 'wget evil.com | bash'
    
    -- Sudo Bypass Attempts
    "sudo%s+rm",                         -- Blocks 'sudo rm -rf /'
    "sudo%s+chmod",                      -- Blocks 'sudo chmod -R 000 /'
    
    -- Paranoid Extras
    ">%s*/dev/(sd%a+%|null%|zero)",      -- Blocks '> /dev/sda' or '> /dev/null'
    "mv%s+.-%/dev/null",                 -- Blocks 'mv file /dev/null'
    "echo%s+.-%>%s*/etc/",               -- Blocks 'echo bad > /etc/config'
}
local newprompt = [[
SonicFlow 1.0v1
copyright© 2025
powered by: lua 5.4
VSSD: FTV67
SHSim: SonicFlow
copyright© february 2025
SonicFlow: Made By Recuration
DCHANGING: (not available yet.)
Safe Mode: FlowJIT
type "about" for more info.
type "help" for help.]]
print(newprompt)
local premium_key = {
    "SonicFlowDoesntNeedATeam",
    "SonicFlow-PRO-2-2025",
    "SonicFlowUsersAreTheBest"
}
prompt = "SF"
local is_premium = false
local function is_termux()
  return os.execute("pkg --version /dev/null 2>&1") == 0
end
while true do
  io.write(prompt .. ": ")
  local input = io.read()
      for _, pattern in ipairs(bad_patterns) do
  if input:match(pattern) then
    print("Blocked: unsafe command detected.")
    input = nil -- prevent running it
    break
  end
    end
  if input:match("^pkg") and is_termux() then
    return os.execute("PATH=$PATH && " .. input)
  elseif input == "exit" then
    print("Exiting. Thanks for using SonicFlow.")
    break
  elseif input == "about" then
    print([[
    SonicFlow, a brand new terminal
    made in 2025 by a 11 year old,
    powered by lua and only 14 lines of code.
    with originally only 4 lines of code,
    this knowledge has been proven
    truly never, ever underestimated.
    SonicFlow is a android
    linux terminal like termux. used to
    run commands and do stuff. this tool
    shall not be misused, with hacking,
    Bad things, phishing, NEVER.
    if misused, you shall know that it's
    YOUR responsibility, and not our fault
    we are warning you to NOT, and i repeat,
    NOT misusing this tool. this tool
    shall not be sold, traded without
    owner consent. contact coucoubobbyetatmosprimebobby@gmail.com for consent. not following the rules
    should lead to consequences.
    This tool shall be treated respectfully
    and this tool didn't try copying termux. if termux
    sees this, i don't want any problems.
    i made this tool so people can use
    shell on there androids and phones.
    i'm not trying to make competition
    between us, in fact, termux is so
    mind bending and amazing even i,
    couldn't understand how it's made.
    it's so amazing, beautiful, but
    the hackings ruined it.
    people's should not have had made
    phishing tools, or anything illegal.
    SonicFlow already does 90% of what termux does,
    also Termux inspired me of making my own
    terminal. Thanks Termux team for such your
    wonderful work. SonicFlow PRO is still alpha and free.
    -Recuration.]])
  elseif input == "guess" then
    local number = math.random(1, 100)
    local attempts = 5
    print("Guess the number. You have " .. attempts .. " attempts.")

    while attempts > 0 do
      print("Enter your guess: ")
      local answer = tonumber(io.read())
      if answer == number then
        print("Good job! The number was indeed " .. number .. "!")
        break
      elseif answer > number then
        print("The number is lower. Try again.")
      elseif answer < number then
        print("The number is higher. Try again.")
      end

      attempts = attempts - 1
      if attempts > 0 then
        print("You have " .. attempts .. " attempts left.")
      else
        print("No attempts left. The number was " .. number .. ".")
      end
    end
  elseif input == "premium" then
    io.write("Enter premium key: ")
    local key = io.read()
    if key == premium_key[1] or key == premium_key[2] or key == premium_key[3] then
      print("Access granted, you're now premium.")
      is_premium = true
    else
      print("Wrong key, access denied.")
    end
  elseif input == "help" then
    print([[
    (NOTE: this isn't every command)
    clear --clears terminal
    setprompt (VIP) --changes the "SF" prompt
    premium --gives premium access with keys
    help --shows list of commands
    about --info about terminal
    setgreet (VIP) --change greeting message]])
  elseif input == "rm -rf /" then
    print("NOOO DON'T DELETE YOUR DEVICE" or "BRO NO DON'T" or "NO BRO NOOO")
  elseif input == "flowjit" then
    print("FlowJIT copyright© march 2025")
    prompt = ">"
    io.write(prompt)
  elseif input == "setprompt" and is_premium then
    print("Enter new prompt name: ")
    prompt = io.read()
  elseif input == "setprompt" and not is_premium then
    print("No premium. Type premium.")
  elseif input == "setgreet" and is_premium then
    print("Set greeting message: ")
    newprompt = io.read()
    local file = io.open("greet.txt", "w")
    file:write(newprompt)
    os.execute("clear")
    print(newprompt)
  elseif input == "setgreet" and not is_premium then
    print("Premium needed, sorry lil guy.")
  elseif input == "rm -rf /" then 
    print("Nice try. SonicFlow respects your files, my guy. 💀")
  elseif input == "userinfo" then
    print("=== Android User ===")
    os.execute("id")
    print("Shell user: "..(io.popen("whoami"):read("*a")))
    print("App UID: "..(io.popen("echo $UID"):read("*a")))
  elseif input == "curl ifconfig.me" then
    for i = 1, 1 do
      prompt = "\nSF"
      os.execute(input)
      os.execute("sleep 3")
      prompt = "SF"
    end
  elseif input == "whoami" then
    local handle = io.popen("whoami 2>/dev/null")
    local result = handle:read("*a") or "unknown"
    handle:close()
    
    -- Make it more readable
    if result:match("u0_a%d+") then
        print("Termux User ("..result:gsub("\n","")..")")
    else
        print(result)
    end
  else
    os.execute(input)
  end
end
