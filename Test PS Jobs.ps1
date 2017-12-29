﻿<#
.SYNOPSIS
	Testing jobs, how to start, read and end them
#>

#require -version 2.0
#create a pool of 3 runspaces
$links = Get-Content links.txt
$pool = [runspacefactory]::CreateRunspacePool(1, $links.Length)
$pool.Open()
write-host "Available Runspaces: $($pool.GetAvailableRunspaces())"

$jobs = @()
$ps = @()
$wait = @()

# run background pipelines
for ($i = 0; $i -lt $links.Length; $i++)
{
    # create a "powershell pipeline runner"
    $ps += [powershell]::create()

    # assign our pool of $links.length runspaces to use
    $ps[$i].runspacepool = $pool

    # test command: beep and wait a certain time
    [void]$ps[$i].AddScript("& .\youtube.exe -uri $links[$i]")

    # start job
    $jobs += $ps[$i].BeginInvoke();

    write-host "Available runspaces: $($pool.GetAvailableRunspaces())"

    # store wait handles for WaitForAll call
    $wait += $jobs[$i].AsyncWaitHandle
}

# wait 20 seconds for all jobs to complete, else abort
$success = [System.Threading.WaitHandle]::WaitAll($wait, 20000)

write-host "All completed? $success"

# end async call
for ($i = 0; $i -lt $links.Length; $i++)
{
    write-host "Completing async pipeline job $i"

    try
    {
        # complete async job
        $ps[$i].EndInvoke($jobs[$i])
    } catch {  
        # oops-ee!
        write-warning "error: $_"
    }

    # dump info about completed pipelines
    $info = $ps[$i].InvocationStateInfo
    write-host "State: $($info.state) ; Reason: $($info.reason)"
}

# should show $links.length again.
write-host "Available runspaces: $($pool.GetAvailableRunspaces())"
