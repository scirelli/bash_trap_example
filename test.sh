#!/usr/bin/env bash

# trap [-lp] [[arg] signal_spec ...]
# or
# trap [action] [signal]
# Key	Description
# ----------------------
# -l	        It is used to display the list of all signal names with corresponding number.
# -p	        It is used to display signal command or trap command for signal_spec.
# arg	        It is used to execute a command when the shell receives the signal(s).
# signal_spec	It contains signal name or signal number.
# ------------------
# Trap command without arg value or with ‘-‘ arg value will reset the specified signal to its original value.
# Trap command with ‘null’ arg value will ignores the specified signal send by the shell or command.
# A signal_spec with the value, exit(0) will execute arg after exiting from the shell.
# A signal_spec with the value debug will execute arg before each single command.
# A signal_spec with the value return will execute arg each time when a shell function executes or a script run by “.”.
# A signal_spec with the value err will execute arg every time on command failure.

# $ trap -l
 # 1) SIGHUP	 2) SIGINT	 3) SIGQUIT	 4) SIGILL
 # 5) SIGTRAP	 6) SIGABRT	 7) SIGEMT	 8) SIGFPE
 # 9) SIGKILL	10) SIGBUS	11) SIGSEGV	12) SIGSYS
# 13) SIGPIPE	14) SIGALRM	15) SIGTERM	16) SIGURG
# 17) SIGSTOP	18) SIGTSTP	19) SIGCONT	20) SIGCHLD
# 21) SIGTTIN	22) SIGTTOU	23) SIGIO	24) SIGXCPU
# 25) SIGXFSZ	26) SIGVTALRM	27) SIGPROF	28) SIGWINCH
# 29) SIGINFO	30) SIGUSR1	31) SIGUSR2
# Additionally trap recognizes:
# EXIT: Occurs when the shell process itself exits
# ERR: Occurs when a command (such as tar or mkdir) or a built-in command (such as pushd or cd) completes with a non-zero status
# DEBUG: A Boolean representing debug mode

# Example catch multiple signals
# trap 'echo Trap command executed' 1 3 9

# Call func function on exit
trap "func" EXIT
trap func2 ERR

throw=false

function func() {
    exit_code=$?
    echo "Task complete. Script exited with '$exit_code'"
    case "$exit_code" in
        232) printf '\tWe got some weird error\n'
            ;;
        0) echo 'All good here'
            ;;
        *) echo "Got unknown error code $exit_code"
    esac
}

function func2() {
    exceptionStr="$_"       # Just the last executed command.
    echo "$exceptionStr: Error at line '$LINENO'"
}

echo "$_"
echo 'Starting script...'
$throw "MyException"
exit 232
