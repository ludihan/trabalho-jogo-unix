class_name VirtualFileSystem
extends Node

# Caminho inicial do sistema de arquivos virtual
var level_path: String
var file_system: File

# Classe que representa um arquivo ou diretório
class File:
	var name: String
	var content: String
	var is_dir: bool
	var links: Array[File]

	func _init(name: String = "", content: String = "", is_dir: bool = false, links: Array[File] = []):
		self.name = name
		self.content = content
		self.is_dir = is_dir
		self.links = links

# Inicialização do sistema de arquivos virtual
func _init(level_path: String):
	self.level_path = level_path
	self.file_system = File.new("root", "", true, [])

# Quando o nó entra na árvore de cena
func _ready() -> void:
	print("Sistema de Arquivos Virtual Pronto")
	print("Estrutura Inicial:", _print_tree(file_system))

# Função para criar um arquivo ou diretório
func create(name: String, is_dir: bool, path: Array[String]) -> bool:
	var current_dir = _navigate_to(path)
	if current_dir == null:
		print("Caminho inválido")
		return false

	if not current_dir.is_dir:
		print("O destino não é um diretório")
		return false

	for link in current_dir.links:
		if link.name == name:
			print("Arquivo/Diretório já existe")
			return false

	var new_file = File.new(name, "", is_dir, [])
	current_dir.links.append(new_file)
	return true

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

# Função para listar o conteúdo de um diretório
func list(path: Array[String]) -> Array[String]:
	var current_dir = _navigate_to(path)
	if current_dir == null:
		print("Caminho inválido")
		return []
		
	var result = []
	for file in current_dir.links:
		var name = file.name
		if file.is_dir:
			name += "/"
		result.append(name)
	return result



# Função para deletar um arquivo/diretório
func delete(name: String, path: Array[String]) -> bool:
	var current_dir = _navigate_to(path)
	if current_dir == null:
		print("Caminho inválido")
		return false

	for i in range(current_dir.links.size()):
		if current_dir.links[i].name == name:
			current_dir.links.remove_at(i)
			return true
	print("Arquivo/Diretório não encontrado")
	return false

# Função para escrever conteúdo em um arquivo
func write(name: String, content: String, path: Array[String]) -> bool:
	var current_dir = _navigate_to(path)
	if current_dir == null:
		print("Caminho inválido")
		return false

	for file in current_dir.links:
		if file.name == name and not file.is_dir:
			file.content = content
			return true

	print("Arquivo não encontrado ou é um diretório")
	return false

# Função para ler conteúdo de um arquivo
func read(name: String, path: Array[String]) -> String:
	var current_dir = _navigate_to(path)
	if current_dir == null:
		print("Caminho inválido")
		return ""

	for file in current_dir.links:
		if file.name == name and not file.is_dir:
			return file.content

	print("Arquivo não encontrado ou é um diretório")
	return ""

# Função para imprimir a árvore do sistema de arquivos
func _print_tree(node: File, depth: int = 0) -> String:
	var result = "  ".repeat(depth) + (node.name + "/" if node.is_dir else node.name) + "\n"
	for link in node.links:
		result += _print_tree(link, depth + 1)
	return result
