class_name VirtualFileSystem
extends Node

# Caminho inicial do sistema de arquivos virtual
var level_path: String
var file_system: File

# Classe que representa um arquivo ou diretório
class File:
	var file_name: String
	var content: String
	var is_dir: bool
	var links: Array[File]

	func _init(_file_name: String, _content: String, _is_dir: bool, _links: Array[File]):
		self.file_name = _file_name
		self.content = _content
		self.is_dir = _is_dir
		self.links = _links

# Inicialização do sistema de arquivos virtual
func _init(_level_path: String):
	self.level_path = _level_path
	self.file_system = _build_fs(level_path)
	file_system.file_name = "root"
	print(_print_tree(file_system))

# Constrói a árvore do sistema de arquivos com base no diretório real
func _build_fs(_level_path: String) -> File:
	var root = File.new(_level_path.get_file(), "", true, [])
	var root_dir = DirAccess.open(_level_path)
	if root_dir == null:
		print("Erro: Não foi possível abrir o diretório ", _level_path)
		return root

	var all_files = root_dir.get_files()
	var all_dir = root_dir.get_directories()
	for file in all_files:
		root.links.append(File.new(file, _read_file_content(file), false, []))
		
	for dir in all_dir:
		root.links.append(_build_fs(_level_path.path_join(dir)))
	
	return root

# Função para ler o conteúdo de um arquivo
func _read_file_content(file_path: String) -> String:
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		return "" # Retorna vazio se não for possível abrir
	var content = file.get_as_text()
	file.close()
	return content

# Função para listar o conteúdo de um diretório
func list(path: Array[String]) -> Array[String]:
	var current_dir = _navigate_to(path)
	if current_dir == null:
		print("Caminho inválido")
		return []
		
	var result = []
	for file in current_dir.links:
		var file_name = file.file_name
		if file.is_dir:
			file_name += "/"
		result.append(file_name)
	return result

# Função para encontrar um arquivo/diretório com base no caminho
func _navigate_to(path: Array[String]) -> File:
	var current_dir = file_system
	for dir_name in path:
		var found = false
		for link in current_dir.links:
			if link.name == dir_name and link.is_dir:
				current_dir = link
				found = true
				break
		if not found:
			return null
	return current_dir

# Função para imprimir a árvore do sistema de arquivos
func _print_tree(node: File, depth: int = 0) -> String:
	var result = "  ".repeat(depth) + (node.file_name + "/" if node.is_dir else node.file_name) + "\n"
	for link in node.links:
		result += _print_tree(link, depth + 1)
	return result
