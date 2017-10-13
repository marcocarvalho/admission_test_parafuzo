[![build status](http://gitlab.parafuzo.com/test/marco-carvalho/badges/master/build.svg)](http://gitlab.parafuzo.com/test/marco-carvalho/commits/master)

# Marco Carvalho

Este projeto tem como objetivo testar os conhecimentos, código e a organização do candidato.

O prazo para entrega é até o dia **13/10/2017**

# O projeto

Criar uma api de controle de estacionamento:

  - Deve registrar entrada, saída e pagamento por placa
  - Não deve liberar saída sem pagamento
  - Deve fornecer um historico por placa

Essa api deve respeitar os status http corretamente, deve aceitar e responder por json.

## Ações que devem ser disponíveis

### Entrada

```
POST /parking
{ plate: 'FAA-1234' }
```

Deve retornar um número de "reserva" e validar a máscara AAA-9999

### Saída

```
PUT /parking/:id/out
```

### Pagamento

```
PUT /parking/:id/pay
```

### Histórico

```
GET /parking/:plate
[
  {id: 42, time: '25 minutes', paid: true, left: false}
]
```

## Sobre testes

Quanto mais melhor! :)

## Tecnologias

O sistema deve ser escrito em ruby (lembre-se: não é um teste de rails, é **ruby**) e usar mongodb como banco de dados.
Deve usar algum gerenciador de docker (preferencialmente docker-compose).
Deve ser criado um Dockerfile para ser usado no deploy de teste.
Caso necessário algum preparo antes de testar é necessário fornecer um INSTALL.md explicando o processo.

## Sobre a avaliação

Este projeto tem como objetivo testar como o programador realiza a divisão de classes, organiza o código e a qualidade de teste.
A descrição do projeto contem o mínimo exigido para considerar o sistema como funcional.

Boa sorte e bora codar! :p

## CURLs para testar

```
curl -X POST -d '{"plate": "aaA-4444"}' http://localhost:3000/parking
curl -X PUT http://localhost:3000/parking/aAa-4444/pay
curl -X PUT http://localhost:3000/parking/AaA-4444/out
```

Invalid Plate error:

```
curl -X POST -d '{"plate": "#####"}' http://localhost:3000/parking
curl -X PUT http://localhost:3000/parking/1231234/pay
curl -X PUT http://localhost:3000/parking/aaaaa/out
curl http://localhost:3000/parking/aaaaaaa
```
