Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

------------------

# Instalação do dbt-core com o Adapter do Snowflake

Este guia fornece instruções passo a passo para instalar o **dbt-core** e configurar o adapter do **Snowflake** para começar a transformar seus dados.

## Pré-requisitos

Antes de iniciar, certifique-se de que você possui:

1. **Python** instalado (versão 3.7 ou superior).
2. **Git** instalado e configurado.
3. Credenciais de acesso ao banco de dados **Snowflake**.
4. Um ambiente de terminal ou shell configurado.

## Etapas de Instalação

### 1. Configurar um Ambiente Virtual
Para evitar conflitos de dependências, crie e ative um ambiente virtual Python:

```bash
# Criar o ambiente virtual
python3 -m venv venv

# Ativar o ambiente virtual
# Para Linux/MacOS
source venv/bin/activate

# Para Windows
venv\Scripts\activate
```

### 2. Instalar o dbt-core e o Adapter do Snowflake
Instale o pacote principal do dbt e o adapter para Snowflake usando `pip`:

```bash
pip install dbt-core dbt-snowflake
```

Como boas práticas, deve-se criar o arquivo __requiriments.txt__ e incluir 
as bilbiotecas para serem instaladas automaticamente com o comando:

```bash
pip install -r requirements.txt
```

### 3. Verificar a Instalação
Após a instalação, verifique se o dbt foi instalado corretamente:

```bash
dbt --version
```

O comando deve exibir a versão do dbt-core e do adapter do Snowflake.

### 4. Configurar o dbt Project

#### 4.1 Criar um Novo Projeto dbt
Navegue até o diretório onde deseja criar o projeto e execute o seguinte comando:

```bash
dbt init meu_projeto_dbt(ou qualquer outro nome)
```

#### 4.2 Configurar o `profiles.yml`
O dbt utiliza o arquivo `profiles.yml` para armazenar informações de conexão com o banco de dados. Por padrão, este arquivo está localizado no diretório `~/.dbt/`.

Edite o arquivo `profiles.yml` e adicione as configurações para o Snowflake:

```yaml
meu_projeto_dbt:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: "<seu_conta>"
      user: "<seu_usuario>"
      password: "<sua_senha>"
      role: "<sua_role>" # Opcional
      database: "<seu_banco>"
      warehouse: "<seu_warehouse>"
      schema: "<seu_esquema>"
      threads: 4
      client_session_keep_alive: False
```

Substitua os campos `<...>` pelas informações específicas do seu ambiente Snowflake.

### 5. Testar a Conexão
Verifique se o dbt consegue se conectar ao Snowflake:

```bash
dbt debug
```

Se tudo estiver configurado corretamente, você verá uma mensagem indicando que a conexão foi bem-sucedida.

## dbt Materializations

No DBT, há vários tipos de materializações que permitem um controle sobre a performance e como os dados são persistidos. 

### 1. **Table**
A materialização `table` cria uma tabela física no banco de dados. Sempre que o modelo é executado, ele cria uma nova tabela substituindo a anterior.

- **Uso recomendado**: Ideal para dados que não mudam frequentemente ou quando você precisa garantir que a tabela final seja recriada a cada execução.
- **Exemplo de uso**:
    ```sql
    {{ config(
      materialized='table'
    ) }}
    ```

### 2. **View**
A materialização `view` cria uma view no banco de dados. Ao contrário das tabelas, as views não armazenam fisicamente os dados, mas apenas armazenam a consulta SQL. Elas são sempre recalculadas quando consultadas.

- **Uso recomendado**: Ideal para modelos que não exigem armazenamento físico dos dados e onde a consulta pode ser recalculada de forma eficiente.
- **Exemplo de uso**:
    ```sql
    {{ config(
      materialized='view'
    ) }}
    ```

### 3. **Ephemeral**
A materialização `ephemeral` cria modelos temporários que não são persistidos no banco de dados. Esses modelos são apenas usados durante a execução de outros modelos e são descartados depois.

- **Uso recomendado**: Ideal para modelos auxiliares que não precisam ser armazenados no banco, como transformações intermediárias.
- **Exemplo de uso**:
    ```sql
    {{ config(
      materialized='ephemeral'
    ) }}
    ```

### 4. **Incremental**
A materialização `incremental` permite adicionar novos dados a uma tabela existente, com base em uma condição de incremento (por exemplo, a data da última atualização). A ideia é evitar a recriação da tabela inteira a cada execução, economizando tempo e recursos computacionais.

- **Uso recomendado**: Ideal para grandes volumes de dados que são atualizados periodicamente, como tabelas de transações ou logs.
