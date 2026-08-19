/// Placeholder: catálogo de mídias de exemplo compartilhado só entre
/// `GroupDetailsViewmodal` (prévia de 4) e `MediaViewmodal` (lista completa),
/// para os números ("Ver todas · N" / "N arquivos") não ficarem
/// inconsistentes entre as duas telas. Substituir quando a camada de dados
/// da feature existir.
const kGroupSampleMediaCount = 12;

List<String> buildSampleMediaUrls({int count = kGroupSampleMediaCount}) {
  return List.generate(
    count,
    (i) => 'https://picsum.photos/seed/duni-group-media-$i/400',
  );
}
