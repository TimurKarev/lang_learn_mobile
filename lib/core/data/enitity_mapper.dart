abstract interface class EntityMapperMixin<E, D> {
  E mapToEntity(D dto);

  D mapToDto(E entity);
}
