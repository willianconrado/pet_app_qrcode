# Resumo das Alterações Finais - Pet App

## 1. Tela "Minha Conta" (my.acc.dart)
- **Salvamento Real:** Implementado o método `_saveProfile` que sincroniza dados entre Firestore e Firebase Auth.
- **Controllers:** Adicionados `TextEditingControllers` para Nome e Telefone com carregamento automático no `initState`.
- **UX de Upload:** Adicionado `_isPhotoLoading` para mostrar um spinner enquanto a foto é enviada ao Storage.
- **Cache Buster:** Implementada query string na URL da imagem para forçar atualização visual imediata.

## 2. AuthService (service.auth.dart)
- **Ajuste de Login Google:** Adicionada lógica para preencher `profileImageUrl` em contas existentes que estavam com o campo vazio.
- **Métodos Restaurados:** 
    - `changeMyPassword`: Recuperação de senha por e-mail.
    - `removeAccount`: Exclusão de conta com reautenticação obrigatória.

## 3. Estabilidade (Crash Prevention)
- **Safe Access:** Substituído `documentSnapshot.get()` por acesso via Map no Firestore em todas as telas de perfil, evitando exceções quando campos estão ausentes.
- **Dispose:** Implementada limpeza de controllers para evitar vazamento de memória.

## 4. Estado do Firebase Storage
- Identificada necessidade de upgrade de plano no Firebase Console para reativar o bucket de imagens. O código do app já está preparado para o funcionamento assim que o serviço for reativado.
