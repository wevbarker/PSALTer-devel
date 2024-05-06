(*=======*)
(*  HPC  *)
(*=======*)

(*
$NodeCPU=110;
Comment@{"The variable $NodeCPU is set to ",ToString@$NodeCPU};
Comment@{"The variable $ProcessorCount is set to ",ToString@$ProcessorCount};
Unprotect@$ProcessorCount;
$ProcessorCount=$NodeCPU;
Comment@{"The variable $ProcessorCount is set to ",ToString@$ProcessorCount};
Comment@{"The variable $KernelCount is set to ",ToString@$KernelCount};
Comment@{"Now we execute LaunchKernels[]"};
LaunchKernels@$NodeCPU;
Comment@{"The variable $KernelCount is set to ",ToString@$KernelCount};
*)
