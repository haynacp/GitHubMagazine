# GitHubMagazine

GitHubMagazine é um aplicativo iOS que lista os repositórios mais populares escritos em Swift no GitHub e permite visualizar detalhes e pull requests dos repositórios. Este projeto foi desenvolvido utilizando uma arquitetura MVVM com modularização para garantir uma melhor manutenção e escalabilidade.

## Solução Adotada

A solução adotada foi baseada na arquitetura MVVM (Model-View-ViewModel) para separar claramente as responsabilidades entre a camada de apresentação e a camada de dados. A utilização de RxSwift e RxCocoa permitiu a implementação de um fluxo de dados reativo, facilitando a ligação entre a View e o ViewModel.

## Libs Utilizadas

- **RxSwift**: Biblioteca para programação reativa.
- **RxCocoa**: Extensões para RxSwift, focadas em Cocoa e Cocoa Touch.
- **SDWebImage**: Biblioteca para carregar e cachear imagens de forma assíncrona.
- **Alamofire**: Biblioteca para realizar requisições HTTP de forma simples e eficiente (não utilizado diretamente no projeto, mas disponível para futuras extensões).

## Arquitetura

O projeto segue a arquitetura MVVM com a seguinte estrutura de pastas:

- **AppDelegate**: Contém a configuração inicial do aplicativo.
- **Modules**:
  - **Common**:
    - **Extensions**: Contém extensões para classes do UIKit e utilitários.
      - `UIColor+Hex.swift`: Extensão para criar cores a partir de códigos hexadecimais.
      - `UINavigationController.swift`: Extensão para navegação personalizada.
      - `UIViewController.swift`: Extensão para adicionar funcionalidades às view controllers.
    - **Models**: Definições das estruturas de dados.
      - `PullRequestsResponse.swift`: Modelo para a resposta de pull requests da API.
      - `RepositoriesResponse.swift`: Modelo para a resposta de repositórios da API.
    - **Networking**: Lida com a comunicação com a API do GitHub.
      - `APIService.swift`: Serviço para fazer requisições à API do GitHub.
      - `APIServiceProtocol.swift`: Protocolo para facilitar a criação de mocks em testes.
    - **Utilities**: Contém utilitários e componentes reutilizáveis.
      - `WebViewController.swift`: View controller para exibir conteúdo web.
  - **PullRequests**: Contém componentes relacionados aos pull requests.
    - `PullRequestCell.swift`: Configuração da célula de pull request.
    - `PullRequestsViewController.swift`: View controller para listar pull requests.
    - `PullRequestsViewModel.swift`: View model para manipular dados de pull requests.
  - **Repositories**: Contém componentes relacionados aos repositórios.
    - `RepositoriesViewController.swift`: View controller para listar repositórios.
    - `RepositoriesViewModel.swift`: View model para manipular dados de repositórios.
    - `RepositoryCell.swift`: Configuração da célula de repositório.
- **Resources**: Contém os recursos utilizados no projeto.

## Escolhas Feitas

- **MVVM**: Para separar a lógica de apresentação da lógica de negócios e facilitar a testabilidade.
- **RxSwift e RxCocoa**: Para lidar com a programação reativa, tornando o fluxo de dados mais previsível e fácil de seguir.
- **SDWebImage**: Para carregamento e cache eficiente de imagens de avatares do GitHub.
- **Modularização**: Para organizar melhor o código e facilitar a manutenção e escalabilidade do projeto.

## Instruções para Executar o Projeto

### Pré-requisitos

- **Xcode**: Versão 11.0 ou superior.
- **Cocoapods**: Para gerenciar as dependências.

### Passos

1. **Clone o repositório:**
```sh
git clone https://github.com:haynacp/GitHubMagazine.git
cd repositorio
```

2. **Instale as dependências:**
```sh
pod install
```

3. **Abra o projeto no Xcode:**
```sh
open GitHubMagazine.xcworkspace
```

4. **Execute o projeto:**

  - Selecione o dispositivo ou simulador desejado.
  - Pressione Cmd + R para compilar e executar o projeto.

### Testes
Para executar os testes, selecione o esquema de testes no Xcode e pressione Cmd + U ou utilize o menu Product -> Test.

## Contato

Se tiver alguma dúvida, sinta-se à vontade para abrir uma issue ou entrar em contato através do email: hayna.cp@gmail.com

