<h3>
Instalando o pacote necessario:
</h3>

<blockquote> <p> Debian/Ubuntu</p> </blockquote>
<pre>sudo apt-get install -y wget curl bc</pre>

<blockquote> <p> Centos/Redhat</p> </blockquote>
<pre>sudo yum install wget curl -y bc</pre>

<blockquote> <p> Faça o download do script</p> </blockquote>
<pre>wget https://raw.githubusercontent.com/danielpereira-gub/API-PROXMOX_ZABBIX/main/ARQUIVOS/api_proxmox.sh bc</pre>


<h3>
Editando o script alterando as variaveis conforme o seu ambiente:
</h3>

<blockquote> <p> INFORMAÇÕES PROXMOX</p> </blockquote>
<pre>PROX_USERNAME=nome_de_usuario_proxmox
PROX_PASSWORD=senha_de_usuario_proxmox
NOME_PROX=nome_do_node_no_proxmox
IP_PROX=ip_proxmox bc</pre>

<blockquote> <p> INFORMAÇÕES ZABBIX</p> </blockquote>
<pre>URL='http://ipzabbix/api_jsonrpc.php'
HEADER='Content-Type:application/json'
USER='"nome_de_usuario_zabbix"'
PASS='"senha_zabbix"'bc</pre>


<blockquote> <p> Altere o hostid para o id do seu host no zabbix</p> </blockquote>
<pre>"params": {
                        "hostid": "10418",
                        "macros": [
bc</pre>


<h3>
Importe o template e crie o host no zabbix colocando as seguintes informações nas macros do host:
</h3>

<blockquote> <p> Macros: x</p> </blockquote>

<img src="https://i.ibb.co/X5WzJfS/image.png"/><br><br>







