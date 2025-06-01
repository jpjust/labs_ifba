# Script para instalação nos laboratórios do IFBA

## Preparação

### Pacotes `.deb`

Caso queira instalar quaisquer pacotes `.deb` na implantação do laboratório copie os arquivos `.deb` dos pacotes que você quer instalar para a pasta `deb`. O script de implantação irá instalar todos os pacotes nesta pasta automaticamente, incluindo eventuais dependências.

### Pacotes `.tar.gz`

Alguns softwares são distribuídos como pacotes `.tar.gz` (ou algum outro formato de compressão). Estou falando de softwares que necessitam apenas que você descompacte o pacote em algum lugar e faça alguns ajustes de variáveis de ambiente.

Nestes casos, crie uma pasta dentro de `pacotes` para o software. Esta pasta deverá ter toda a estrutura de diretórios equivalente dentro da partição raíz.

Por exemplo, imagine que queira empacotar o IntelliJ em `/opt/intellij`. Siga este passo a passo:

1. Crie a pasta para o pacote:

```sh
mkdir pacotes/intellij
```

2. Crie a pasta `opt` onde o IntelliJ serã́ descompactado:

```sh
mkdir pacotes/intellij/opt
```

3. Descompacte o tarball do IntelliJ dentro da pasta `opt`:

```sh
cd pacotes/intellij/opt
tar -zxvf ~/Downloads/ideaIC-xxx-yyy.tar.gz
```

4. Caso queira adicionar variáveis de ambiente, crie um arquivo shell em `pacotes/intellij/etc/profile.d` com os comandos de configuração. Isto vale também para qualquer outra configuração de perfil de usuário que seja necessária.

5. Caso queira adicionar um ícone de atalho no menu do ambiente gráfico, crie um arquivo `.desktop` em `pacotes/intellij/usr/share/applications`. Veja um exemplo:

```
[Desktop Entry]
Name=IntelliJ
Comment=IntelliJ
Exec=/opt/intellij/bin/idea.sh
Icon=/opt/intellij/bin/idea.svg
Terminal=false
Type=Application
Categories=Development;
```

Perceba que neste exemplo o IntelliJ será instalado em `/opt/intellij`.

Após ter preparado todos os pacotes de software execute o script `gera-pacotes.sh` dentro da pasta `pacotes`.

### Pasta dos usuários

Em `pacotes/usuarios` você poderá adicionar arquivos que serão copiados automaticamente às pastas dos usuários `aluno1` e `aluno2`. Coloque os arquivos obedecendo a hierarquia de pastas dos usuários do Linux.

## Implantação

1. Copie todos os arquivos para um pen drive, exceto a pasta `pacotes`. Ela é usada para gerar os arquivos em `files`.

2. Execute `script.sh` para fazer a implantação. Preste atenção, pois em alguns momentos poderão ser solicitados alguns prompts de instalação dos pacotes e os dados dos usuários `aluno1` e `aluno2`.

3. Após a implantação, reinicie.

## Reset de usuários

Para resetar os usuários, ou seja, limpar as pastas dos usuários e voltar ao estado pós-implantação, execute o script `/root/reset-usuarios.sh`.

ATENÇÂO: Todos os arquivos das pastas dos usuários (todos os usuários do sistema) serão permanentemente apagados!

Recomenda-se fazer isso após o final de cada semestre ou ano letivo para deixar o laboratório pronto para o próximo período.
