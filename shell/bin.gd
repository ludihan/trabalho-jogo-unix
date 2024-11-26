extends Node

static var bin_dict := {
	"MAN": man_bin,
	"LS": ls_bin,
	"CD": cd_bin,
	"PWD": pwd_bin,
	"ECHO": echo_bin,
}

static func man_bin(args: Array, is_pipe: bool, previous_command: CommandResult) -> CommandResult:
	print(is_pipe)
	print("Previous Command Output:", previous_command.output)
	print(args)
	return CommandResult.new(
"MAN [PROGRAMA]  MOSTRA AJUDA SOBRE COMANDOS
LS  [DIRETORIO] MOSTRA CONTEUDO DE DIRETORIOS
CD  DIRETORIO   MUDA DE DIRETORIO
PWD             MOSTRA DIRETORIO ATUAL
CAT ARQUIVO     MOSTRA / CONCATENA CONTEUDO DE ARQUIVOS\n", CommandResult.TerminationStatus.EXIT_SUCCESS)

static func ls_bin(args: Array, is_pipe: bool, previous_command: CommandResult) -> CommandResult:
	print(is_pipe)
	print("Previous Command Output:", previous_command.output)
	print(args)
	# Simulação do comando LS
	var output = "FILES: " + (args[0] if args.size() > 0 else ".") + "\n"
	return CommandResult.new(output, CommandResult.TerminationStatus.EXIT_SUCCESS)


static func cd_bin(args: Array, is_pipe: bool, previous_command: CommandResult) -> CommandResult:
	print(is_pipe)
	print("Previous Command Output:", previous_command.output)
	print(args)
	# Simulação do comando CD
	if args.size() > 0:
		var dir = args[0]
		return CommandResult.new("DIR CHANGED TO: \n" + dir, CommandResult.TerminationStatus.EXIT_SUCCESS)
	else:
		return CommandResult.new("ERROR: NO DIR ESPECIFIED.\n", CommandResult.TerminationStatus.EXIT_FAILURE)


static func pwd_bin(args: Array, is_pipe: bool, previous_command: CommandResult) -> CommandResult:
	print(is_pipe)
	print("Previous Command Output:", previous_command.output)
	print(args)
	# Simulação do comando PWD
	var output = "/HOME/USER\n"  # Exemplo de saída do diretório
	return CommandResult.new(output, CommandResult.TerminationStatus.EXIT_SUCCESS)


static func echo_bin(args: Array, is_pipe: bool, previous_command: CommandResult) -> CommandResult:
	print(is_pipe)
	print("Previous Command Output:", previous_command.output)
	print(args)
	# Simulação do comando ECHO
	var a = PackedStringArray(args)
	var output = " ".join(a) + "\n"
	return CommandResult.new(output, CommandResult.TerminationStatus.EXIT_SUCCESS)
