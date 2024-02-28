# Modelo Lógico

Um modelo lógico é uma representação abstrata de um banco de dados, que descreve a estrutura dos dados, as operações que podem ser realizadas sobre eles e as restrições que se aplicam a esses dados.

## Entidades e Atributos

Cliente:
```
ClienteID          :: int            (Chave Primária)
Nome               :: nvarchar(500)
Telefone           :: nvarchar(9)    (Unique)
Email              :: nvarchar(320)  (Unique)
DataNascimento     :: Date
Sexo               :: bit/char
Endereço           :: nvarchar(1000) (Nullable)
```

Detetive:
```
DetetiveID         :: int            (Chave Primária)
Nome               :: nvarchar(500)
Telefone           :: nvarchar(9)    (Unique)
Email              :: nvarchar(320)  (Unique)
DataNascimento     :: Date
Sexo               :: bit/char
Salário            :: Decimal/Money
DataContratação    :: Date
DataFimContratação :: Date           (Nullable)
Especialidade      :: nvarchar(100)
Posição            :: bit/char                           <efetivo|estagiário>
Estado             :: bit/char                           <contradado|demitido|aposentado>
Endereço           :: nvarchar(1000) (Nullable)
```

---

Testemunha:
```
TestemunhaID       :: int            (Chave Primária)
Nome               :: nvarchar(500)
Telefone           :: nvarchar(9)
Email              :: nvarchar(320)
DataNascimento     :: Date
Sexo               :: bit/char
Endereço           :: nvarchar(1000) (Nullable)

<!-- CasoID             :: int            (Chave Estrangeira) ** Nota: CasoID quando a testemunha esta associada a varios casos -->
```

Map testemunhas:
```
MapTestemunhasID   :: int            (Chave Primária)
CasoID             :: int            (Chave Estrangeira)
TestemunhaID       :: int            (Chave Estrangeira)
```

exemplo:
CasoID = 1, TestemunhaID = 1
CasoID = 2, TestemunhaID = 1

CasoID = 1, TestemunhaID = 1
CasoID = 1, TestemunhaID = 2

---

Suspeito:
```
SuspeitoID         :: int            (Chave Primária)
CasoID             :: int            (Chave Estrangeira)
Nome               :: nvarchar(500)
Telefone           :: nvarchar(9)
Email              :: nvarchar(320)
DataNascimento     :: Date
Sexo               :: bit/char
Endereço           :: nvarchar(1000) (Nullable)
Descrição          :: nvarchar(2000)
```

Caso:
```
CasoID             :: int            (Chave Primária)
ClienteID          :: int            (Chave Estrangeira)
DetetiveID         :: int            (Chave Estrangeira) [detetive responsável]
DataAbertura       :: Date
DataFechamento     :: Date           (Nullable)
Descrição          :: nvarchar(2000)
Estado             :: bit/char                           <aberto|resolvido|arquivado>
```

Atribuição:
```
AtribuiçãoID       :: int            (Chave Primária)
CasoID             :: int            (Chave Estrangeira)
DetetiveID         :: int            (Chave Estrangeira)
DataAtribuição     :: Date
DataConclusão      :: Date           (Nullable)
Descrição          :: nvarchar(2000)
Estado             :: bit/char
```

Evidência:
```
EvidênciaID        :: int            (Chave Primária)
AtribuiçãoID       :: int            (Chave Estrangeira)
DataColeta         :: Date
Descrição          :: nvarchar(2000)
Tipo               :: bit/char                           <testemunhal|documental|pericial|indicial|real>
Arquivo            :: nvarchar(1000) (Nullable)          <foto|vídeo|áudio|documento> [path/link]
```

Comunicação: (Entre detetive e cliente/testemunha)
```
ComunicaçãoID      :: int            (Chave Primária)
DetetiveID         :: int            (Chave Estrangeira)
ClienteID          :: int            (Chave Estrangeira) (Nullable) ***
TestemunhaID       :: int            (Chave Estrangeira) (Nullable) ***
Data               :: Date
Descrição          :: nvarchar(2000)
Arquivo            :: nvarchar(1000) (Nullable)          <foto|vídeo|áudio|documento> [path/link]
```

Comunicações podem ser feitas de detetive para cliente ou de detetive para testemunha.

*** ClienteID e TestemunhaID são campos mutuamente exclusivos.

Despesa:
```
DespesaID          :: int            (Chave Primária)
DetetiveID         :: int            (Chave Estrangeira)
Data               :: Date
Descrição          :: nvarchar(2000)
Valor              :: Decimal/Money
Arquivo            :: nvarchar(1000) (Nullable)          <nota fiscal|recibo|comprovativo> [path/link]
```

Pagamento:
```
PagamentoID        :: int            (Chave Primária)
AtribuiçãoID       :: int            (Chave Estrangeira)
<!-- ClienteID          :: int            (Chave Estrangeira) -->
Data               :: Date
Descrição          :: nvarchar(1000)
Valor              :: Decimal/Money
Arquivo            :: nvarchar(1000) (Nullable)          <nota fiscal|recibo|comprovativo> [path/link]
```

Categoria:
```
CategoriaID        :: int            (Chave Primária)
Desginação         :: nvarchar(100)  (Unique)
```

## Relacionamentos

- Client -> Caso (1:N)
    - Um cliente pode estar associado a vários casos, mas um caso só pode ter um cliente
- Detetive -> Caso (1:N)
    - Um detetive pode estar associado a vários casos, mas um caso só pode ter um detetive (responsável)
- Caso -> Atribuição (1:N)
    - Um caso pode ter várias atribuições, mas uma atribuição só pode estar associada a um caso
- Detetive -> Atribuição (1:N)
    - Um detetive pode ter várias atribuições, mas uma atribuição só pode estar associada a um detetive
- Atribuição -> Evidência (1:N)
    - Uma atribuição pode ter várias evidências, mas uma evidência só pode estar associada a uma atribuição
- Caso -> Testemunha (1:N)
    - Um caso pode ter várias testemunhas, mas uma testemunha só pode estar associada a um caso
- Detetive -> Comunicação (1:N)
    - Um detetive pode ter várias comunicações, mas uma comunicação só pode estar associada a um detetive
- Cliente -> Comunicação (1:N)
    - Um cliente pode ter várias comunicações, mas uma comunicação só pode estar associada a um cliente
- Testemunha -> Comunicação (1:N)
    - Uma testemunha pode ter várias comunicações, mas uma comunicação só pode estar associada a uma testemunha
- Detetive -> Despesa (1:N)
    - Um detetive pode ter várias despesas, mas uma despesa só pode estar associada a um detetive
- Caso -> Pagamento (1:N)
    - Um caso pode ter vários pagamentos, mas um pagamento só pode estar associado a um caso
- Cliente -> Pagamento (1:N)
    - Um cliente pode ter vários pagamentos, mas um pagamento só pode estar associado a um cliente

O número de relacionamentos é igual ao número de chaves estrangeiras, ou seja, 12.

## Exemplo de queries SQL

```sql
-- Listar todos os casos abertos
SELECT * FROM Caso WHERE Estado = 'aberto';

-- Listar todos os detetives ativos da agência
SELECT * FROM Detetive WHERE Estado = 'contratado' AND DataDemissão IS NULL;

--Listar todas as atribuições de um detetive específico (ex: DetetiveID = 1)
SELECT * FROM Atribuição WHERE DetetiveID = 1;

-- Listar todas as evidências de uma atribuição específica (ex: AtribuiçãoID = 1)
SELECT * FROM Evidência WHERE AtribuiçãoID = 1;

-- Listar todas as evidências de um caso específico (ex: CasoID = 1)
SELECT * FROM Evidência WHERE AtribuiçãoID IN (SELECT AtribuiçãoID FROM Atribuição WHERE CasoID = 1);

-- Listar todos detetives associados a um caso específico (ex: CasoID = 1)
SELECT * FROM Detetive WHERE DetetiveID IN (SELECT DetetiveID FROM Atribuição WHERE CasoID = 1);
```

## Dúvidas e Observações

- nvarchar ou varchar?
- bit ou char?
- relacões são todas 1:N é ok?
- Tamanhos dos campos estão adequados?
- A tabela Suspeito é similar a Testemunha, tem problema? (tirando o atributo Descrição)
