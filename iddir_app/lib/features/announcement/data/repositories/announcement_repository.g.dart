// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$announcementRepositoryHash() =>
    r'645a7173efbd0c00b3bbd7878bb1953db06d3a23';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$AnnouncementRepository
    extends BuildlessAutoDisposeNotifier<AnnouncementRemoteDatasource> {
  late final Dio dio;

  AnnouncementRemoteDatasource build(Dio dio);
}

/// See also [AnnouncementRepository].
@ProviderFor(AnnouncementRepository)
const announcementRepositoryProvider = AnnouncementRepositoryFamily();

/// See also [AnnouncementRepository].
class AnnouncementRepositoryFamily
    extends Family<AnnouncementRemoteDatasource> {
  /// See also [AnnouncementRepository].
  const AnnouncementRepositoryFamily();

  /// See also [AnnouncementRepository].
  AnnouncementRepositoryProvider call(Dio dio) {
    return AnnouncementRepositoryProvider(dio);
  }

  @override
  AnnouncementRepositoryProvider getProviderOverride(
    covariant AnnouncementRepositoryProvider provider,
  ) {
    return call(provider.dio);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'announcementRepositoryProvider';
}

/// See also [AnnouncementRepository].
class AnnouncementRepositoryProvider
    extends
        AutoDisposeNotifierProviderImpl<
          AnnouncementRepository,
          AnnouncementRemoteDatasource
        > {
  /// See also [AnnouncementRepository].
  AnnouncementRepositoryProvider(Dio dio)
    : this._internal(
        () => AnnouncementRepository()..dio = dio,
        from: announcementRepositoryProvider,
        name: r'announcementRepositoryProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$announcementRepositoryHash,
        dependencies: AnnouncementRepositoryFamily._dependencies,
        allTransitiveDependencies:
            AnnouncementRepositoryFamily._allTransitiveDependencies,
        dio: dio,
      );

  AnnouncementRepositoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dio,
  }) : super.internal();

  final Dio dio;

  @override
  AnnouncementRemoteDatasource runNotifierBuild(
    covariant AnnouncementRepository notifier,
  ) {
    return notifier.build(dio);
  }

  @override
  Override overrideWith(AnnouncementRepository Function() create) {
    return ProviderOverride(
      origin: this,
      override: AnnouncementRepositoryProvider._internal(
        () => create()..dio = dio,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dio: dio,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<
    AnnouncementRepository,
    AnnouncementRemoteDatasource
  >
  createElement() {
    return _AnnouncementRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AnnouncementRepositoryProvider && other.dio == dio;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dio.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AnnouncementRepositoryRef
    on AutoDisposeNotifierProviderRef<AnnouncementRemoteDatasource> {
  /// The parameter `dio` of this provider.
  Dio get dio;
}

class _AnnouncementRepositoryProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          AnnouncementRepository,
          AnnouncementRemoteDatasource
        >
    with AnnouncementRepositoryRef {
  _AnnouncementRepositoryProviderElement(super.provider);

  @override
  Dio get dio => (origin as AnnouncementRepositoryProvider).dio;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
