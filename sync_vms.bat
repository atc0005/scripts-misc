:: Purpose: Sync VMs from source disk to two backup drives

SET SOURCE_DIR=S:\virtual_machines
SET MIRROR_DIR1=D:\virtual_machines\_backups_
SET MIRROR_DIR2=G:\virtual_machines\_backups_

:: Sync both locations, toss any changes at the target location
set ROBOCOPY_MIRROR_OPTIONS=/Z /MIR

:: Virtual machine folders here
FOR %%A IN (

vm1.example.com
vm2.example.com

) DO (

    robocopy %ROBOCOPY_MIRROR_OPTIONS% %SOURCE_DIR%\%%A %MIRROR_DIR1%\%%A
    robocopy %ROBOCOPY_MIRROR_OPTIONS% %SOURCE_DIR%\%%A %MIRROR_DIR2%\%%A

)
