#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use lib '.';
use inc::Module::Install 1.02;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'VideoCatalog';
all_from 'lib/VideoCatalog.pm';

requires 'Catalyst::Runtime' => '5.90128';
requires 'Catalyst::Authentication::Realm::SimpleDB';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Helper::Model::DBIC::Schema';
required 'Catalyst::Helper::View::Bootstrap';
# model create helper
requires 'DBIx::Class::Schema::Loader';
# Session persistent between Controllers
required 'Catalyst::Plugin::Session::State::Cookie';
required 'Catalyst::Plugin::Session::Store::File';
required 'Catalyst::Plugin::StatusMessage';
# Authentication 
required 'Catalyst::Plugin::Authentication';
required 'Catalyst::Plugin::Authorization::Roles';
# SHA-1 password
required 'DBIx::Class::PassphraseColumn';
requires 'DBIx::Class::TimeStamp';
requires 'SQL::Translator';
requires 'Email::Valid';
requires 'Catalyst::Action::RenderView';
requires 'Term::Size::Any';
requires 'Moose';
requires 'MooseX::NonMoose~0.25';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
# just to define terminal size
requires 'Term::Size::Any';
test_requires 'Test::More' => '0.88';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
