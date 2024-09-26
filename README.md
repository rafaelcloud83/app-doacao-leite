<h1>Doa Leite - Aplicativo de doação de Leite em Pó com Fórmulas Infantis</h1> 

<p align="center">
  <img src="https://img.shields.io/static/v1?label=dart&message=language&color=blue&style=for-the-badge&logo=DART"/>  
  <img src="https://img.shields.io/static/v1?label=flutter&message=framework&color=blue&style=for-the-badge&logo=FLUTTER"/>   
   <img src="https://img.shields.io/static/v1?label=STATUS&message=CONCLUIDO&color=GREEN&style=for-the-badge"/>
</p>

<p align="center">
  <img alt="Logo" title="#Logo" src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/LeiteLogo.png?raw=true" width="150px">
</p>

# Introdução

<h2>Sabe-se da importância do aleitamento materno até os seis meses, porém tem Mães que por algum motivo não produz, ou produz pouco Leite Materno, ou também não possui recursos financeiros para comprar o Leite em pó com fórmulas infantis. Isso me motivou a desenvolver este aplicativo para a atividade extensionista da faculdade.<br>
O aplicativo tem o objetivo de fazer a conexão entre o Recebedor e o Doador de maneira simples e eficaz.</h2>

## Sumário

* [Regras de Negócio](#regras-de-negócio)
* [Tecnologias e Ferramentas utilizadas](#tecnologias-e-ferramentas-utilizadas)
* [Dependências](#dependências)
* [Execução do projeto](#execução-do-projeto)
* [Telas do aplicativo](#telas-do-aplicativo)
* [APK do Android rodando com API na Oracle Cloud](#apk-do-android)

## Regras de Negócio
[voltar ao início](#introdução)
- Existe 3 perfis de usuários: Recebedor, Doador e Admin;
- Existe 3 status da doação: Aguardando, Doado e Concluído;
- O usuário Recebedor pode criar um pedido de doação, este pedido receberá o status de Aguardando e aparecerá para todos os usuários Doador;
- O usuário Doador escolhe um pedido de doação para fazer a doação, este pedido receberá o status de Doado e ficará aguardando a confirmação de recebimento do Leite pelo usuário Recebedor;
- Após o usuário Doador enviar o Leite, o usuário Recebedor ao receber o Leite deve confirmar o recebimento do Leite, depois de confirmar o status mudará para Concluido finalizando o processo;
- O usuário Admin tem informações básicas sobre os usuários e doações.

## Tecnologias e Ferramentas utilizadas
[voltar ao início](#introdução)
- **Dart - 3.3.4**
- **Flutter - 3.19.6**
- **VSCode**

## Dependências
[voltar ao início](#introdução)

Para rodar o aplicativo é necessário o uso da API: https://github.com/rafaelcloud83/backend-doacao-leite

## Execução do projeto
[voltar ao início](#introdução)

Primeiramente clone o projeto com o comando:

- Clonar com HTTPS;

```shell
git clone https://github.com/rafaelcloud83/app-doacao-leite.git
```

- Abra o projeto no VSCode;
- Abra o emulador Android ou conecte o celular;
- Clique com o botão direto do mouse no arquivo `main.dart` e clique na opção `Run Without Debugging`.

## Telas do aplicativo
[voltar ao início](#introdução)

Observação: Os dados e informações nas telas são fictícios.

<p align="center">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/00-splash.png?raw=true" width="190px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/01-login.png?raw=true" width="200px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/02-cadastroUsuario.png?raw=true" width="200px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/03-recebedor.png?raw=true" width="225px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/04-recebedorNovaDoacao.png?raw=true" width="225px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/05-recebedorMeusDados.png?raw=true" width="225px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/06-recebedorAlterarDados.png?raw=true" width="225px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/07-recebedorAtualizarDoacao.png?raw=true" width="225px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/08-doadorSemDoacao.png?raw=true" width="225px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/09-doadorMeusDados.png?raw=true" width="225px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/10-doadorAlterarDados.png?raw=true" width="225px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/11-doadorFazerDoacao.png?raw=true" width="225px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/12-doadorConfirmaDoacao.png?raw=true" width="225px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/13-doadorDoacoes.png?raw=true" width="225px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/14-doadorDetalhesDoacao.png?raw=true" width="225px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/15-recebedorDoacoes.png?raw=true" width="225px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/16-recebedorConfirmaDoacao.png?raw=true" width="225px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/17-recebedorDetalhesDoacaoConcluida.png?raw=true" width="225px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/18-adminInicial.png?raw=true" width="225px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/19-adminTodosUsuarios.png?raw=true" width="225px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/20-adminDetalhesUsuario.png?raw=true" width="225px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/21-adminTodasDoacoes.png?raw=true" width="225px">
  <img src="https://github.com/rafaelcloud83/assets-repository/blob/main/appDoacao/22-adminDetalhesDoacao.png?raw=true" width="225px">
</p>

## APK do Android
[voltar ao início](#introdução)

Caso queira testar o aplicativo integrado com API na Oracle Cloud baixe o APK e instale no celular pelo link abaixo. OBS: Por ser um serviço gratuito pode ocorrer instabilidade na API.

https://objectstorage.sa-vinhedo-1.oraclecloud.com/n/ax0fyrtfzxkl/b/bucket-imagensapk/o/app-release.apk
