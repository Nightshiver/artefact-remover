# artefact-remover
Batch script for removing artefacts left over from malware/infections. Why batch and not powershell or python? Those require permissions and modules to be loaded in many environments, whereas the Windows has built in cmd's that are on all Windows machines, so no need for other dependencies.

Script will need to be run as administrator for several functions, such as making a system restore point or creating/deleting services. This script is mainly targeted for those in incdient response roles at an MSSP/MDR provider and have a need for additional remediation that security products do not provide, as even modern one's such as Cb Defense, Crowdstrike, Cybereason, etc will kill an active malicious process and/or remove the malicious file, there can still be leftover remnenants that those products cannot remove.

#### To Do List:
1. Add multifile to the other functions besides files.
2. Find a way to have multifile just be called instead of copy/pasting the function into each section.
3. Additional error/safety checks as needed.
